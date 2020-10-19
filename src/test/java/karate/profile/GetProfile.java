package karate.profile;

import com.intuit.karate.junit5.Karate;

public class GetProfile {
    @Karate.Test
    Karate testSample() {
        return Karate.run("classpath:karate/profile/getprofile.feature").relativeTo(getClass());
    }
}
