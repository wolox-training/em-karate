package karate;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class AllFeatureTest {

    private static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "herokuapp");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
    @Test
    public void testParallel() {
        String karateOutputPath = "target/surefire-reports";
        Results results = Runner.parallel(getClass(), 1, karateOutputPath);
        generateReport(results.getReportDir());
        Assertions.assertEquals(0, results.getFailCount());
    }
}
