package karate.article;

import com.intuit.karate.junit5.Karate;

public class GetArticle {
    @Karate.Test
    Karate testSample() {
        return Karate.run("classpath:karate/article/getArticle.feature").relativeTo(getClass());
    }
}
