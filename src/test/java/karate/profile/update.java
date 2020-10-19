package karate.profile;

import com.intuit.karate.junit5.Karate;

public class update {
    @Karate.Test
    Karate testSample() {
        return Karate.run("classpath:karate/profile/updateprofile.feature").relativeTo(getClass());
    }
}
