package karate.sign_up;

import com.intuit.karate.junit5.Karate;

public class Sign_up {
    @Karate.Test
    Karate testSample() {
        return Karate.run("classpath:karate/sign_up/sign_up.feature").relativeTo(getClass());
    }
}
