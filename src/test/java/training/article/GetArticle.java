package training.article;

import com.intuit.karate.junit5.Karate;

public class GetArticle {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("getArticle").relativeTo(getClass());
    }
}
