package pauta;

import com.intuit.karate.junit5.Karate;

public class PautaRuuner {
    @Karate.Test
    Karate testUsers() {
        return Karate.run("pauta").relativeTo(getClass());
    }
}
