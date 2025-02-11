import org.kohsuke.stapler.verb.POST;
import org.kohsuke.stapler.interceptor.RequirePOST;
import org.kohsuke.stapler.QueryParameter;
import org.kohsuke.stapler.StaplerRequest;
import org.kohsuke.stapler.StaplerRequest2;

import java.net.URL;

public class WebMethodMissingPermissionCheck {
    @POST
    public void doWhatever(@QueryParameter String foo) throws Exception {
        new URL("value").openConnection();
    }

    @RequirePOST
    public void doWhatever2(StaplerRequest req) throws Exception {
        new URL("value").openConnection();
    }

    @RequirePOST
    public void doWhatever3(StaplerRequest2 req) throws Exception {
        new URL("value").openConnection();
    }
}