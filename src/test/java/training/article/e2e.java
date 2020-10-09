package training.article;

import com.intuit.karate.junit5.Karate;

public class e2e {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("e2e").relativeTo(getClass());
    }
}
