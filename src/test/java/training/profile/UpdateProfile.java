package training.profile;

import com.intuit.karate.junit5.Karate;

public class UpdateProfile {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("updateprofile").relativeTo(getClass());
    }
}
