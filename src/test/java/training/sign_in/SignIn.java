package training.sign_in;

import com.intuit.karate.junit5.Karate;

public class SignIn {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("sign_in").relativeTo(getClass());
    }
}
