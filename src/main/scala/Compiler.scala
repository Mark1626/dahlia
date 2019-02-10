package fuselang

import scala.util.{Try, Success, Failure}

object Compiler {

  def compileString(prog: String, c: Utils.Config) = Try {
    val ast = FuseParser.parse(prog)
    TypeChecker.typeCheck(ast)
    Emit.emitProg(ast, c)
  } match {
    case Success(out) => out
    case Failure(f: RuntimeException) =>
      "[" + Console.RED + "Error" + Console.RESET + "] " + f.getMessage
    case Failure(f) => throw f
  }
}