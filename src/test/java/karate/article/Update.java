package karate.article;

import com.intuit.karate.junit5.Karate;

public class Update {
    @Karate.Test
    Karate testSample() {
        return Karate.run("classpath:karate/article/update.feature").relativeTo(getClass());
    }
}
