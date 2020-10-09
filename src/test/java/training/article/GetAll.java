package training.article;

import com.intuit.karate.junit5.Karate;

public class GetAll {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("getAll").relativeTo(getClass());
    }
}
