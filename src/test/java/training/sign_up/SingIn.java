package training.sign_up;

import com.intuit.karate.junit5.Karate;

public class SingIn {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("sing_in").relativeTo(getClass());
    }
}
