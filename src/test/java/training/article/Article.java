package training.article;

import com.intuit.karate.junit5.Karate;

public class Article {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("article").relativeTo(getClass());
    }
}
