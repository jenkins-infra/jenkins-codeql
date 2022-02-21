This check identified that one of the classes listed below is used. Use of these classes is potentially unsafe, usually due to bad defaults or inherent issues invoking these with user data.
Care needs to be taken that use of these classes does not cause security issues. See the [documentation on misc APIs use in Jenkins](https://www.jenkins.io/doc/developer/security/misc/) for recommendations.

Using these classes with user-controlled input is generally unsafe:

* `groovy.lang.GroovyShell`
* `groovy.text.SimpleTemplateEngine`
* `groovy.util.GroovyScriptEngine`
* `hudson.ExpressionFactory2`
* `hudson.util.spring.BeanBuilder`
* `javaposse.jobdsl.dsl.DslScriptLoader`
* `org.apache.commons.jelly.GroovyShell`
* `org.apache.commons.jelly.Script`

XML processing can easily result in XXE vulnerabilities unless specifically disabled:

* `hudson.util.Digester2`
* `javax.xml.transform.TransformerFactory`
* `org.apache.commons.digester.Digester`
* `org.apache.commons.digester3.Digester`
