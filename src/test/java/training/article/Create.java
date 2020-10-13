package training.article;

import com.intuit.karate.junit5.Karate;

public class Create {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("create").relativeTo(getClass());
    }
}
