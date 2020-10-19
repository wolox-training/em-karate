package karate.sign_in;

import com.intuit.karate.junit5.Karate;

public class Sign_in {
    @Karate.Test
    Karate testSample() {
        return Karate.run("classpath:karate/sign_in/sign_in.feature").relativeTo(getClass());
    }
}
