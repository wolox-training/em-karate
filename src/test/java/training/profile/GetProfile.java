package training.profile;

import com.intuit.karate.junit5.Karate;

public class GetProfile {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("getprofile").relativeTo(getClass());
    }
}
