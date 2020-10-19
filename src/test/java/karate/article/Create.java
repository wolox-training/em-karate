package karate.article;

import com.intuit.karate.junit5.Karate;

public class Create {
    @Karate.Test
    Karate testSample() {
        return Karate.run("classpath:karate/article/create.feature").relativeTo(getClass());
    }
}
