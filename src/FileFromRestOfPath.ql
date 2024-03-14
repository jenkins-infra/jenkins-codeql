/**
 * @name Use of StaplerRequest#getRestOfPath to construct a file path
 * @description #getRestOfPath and/or the file path resulting from its use needs to be carefully sanitized to not result in a path traversal vulnerability.
 * @kind problem
 * @problem.severity warning
 * @precision medium
 * @id jenkins/file-from-rest-of-path
 * @tags security
 *       external/cwe/cwe-22
 *       external/cwe/cwe-73
 */

import java
import semmle.code.java.dataflow.TaintTracking

class RestOfPathSource extends DataFlow::ExprNode {
    RestOfPathSource() {
        exists(Method m | m = this.asExpr().(MethodCall).getMethod() |
            m.hasName("getRestOfPath")
            //and m.getDeclaringType() instanceof TBD
        )
    }
}

class FileSink extends DataFlow::ExprNode {
  FileSink() {
    exists(Constructor c, ConstructorCall cc | cc.getConstructor() = c |
      cc.getAnArgument() = this.getExpr() and c.getDeclaringType().hasQualifiedName("java.io", "File")
    )
  }
}

module RestOfPathToFile implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node source) { source instanceof RestOfPathSource }
  predicate isSink(DataFlow::Node sink) { sink instanceof FileSink }
}

module Flow = TaintTracking::Global<RestOfPathToFile>;

from DataFlow::Node source, DataFlow::Node sink
where Flow::flow(source, sink)
select  source, "A file is created from #getRestOfPath, potential path traversal vulnerability $@.", sink, "here"
