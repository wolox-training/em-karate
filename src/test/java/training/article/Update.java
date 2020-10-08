package training.article;

import com.intuit.karate.junit5.Karate;

public class Update {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("update").relativeTo(getClass());
    }
}
