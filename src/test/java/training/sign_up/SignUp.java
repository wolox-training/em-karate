package training.sign_up;

import com.intuit.karate.junit5.Karate;
import org.testng.annotations.BeforeClass;

public class SignUp {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("sign_up").relativeTo(getClass());
    }

}

