import std.stdio;
import state_machine;
struct IdlePower {

   mixin StateMachine!status;
   private enum IdlePowerStatus {
      idle,
      done
   }
   private IdlePowerStatus status = IdlePowerStatus.idle;


   @property bool isDone() {
      return this.done;
   }
}

unittest {
   IdlePower ip = IdlePower();
   assert(!ip.isDone);

}

class Wait {
   private enum Status {
      cleanup,
      done,
      error,
      halt,
      idle,
      running,
      timeout,
      waitDelay, // attende il delay finale
      waitTrue, // attende che l'espressione sia true
   }
   mixin StateMachine!status;

   Status status = Status.idle;
   @BeforeTransition("timeout") private bool EnterTest() {
      writefln("BEFORE GUARD transition timeout status: %s prev: %s", status, this.prevstatus);
      // ritorna true se lo stato e' idle.
      // E' equivalente a
      // return status == Status.idle;
      return this.idle;
   }

   @BeforeTransition("timeout") private void BTimeout() {
      writefln("BEFORE transition timeout status: %s prev: %s", status, this.prevstatus);
   }

   @AfterTransition("timeout") private void ATimeout() {
      writefln("AFTER transition timeout status: %s prev: %s", status, this.prevstatus);
   }

   @BeforeTransition("done") private void Bdone() {
      writefln("BEFORE transition done status: %s prev: %s", status, this.prevstatus);
   }

   @AfterTransition("done") private void Adone() {
      writefln("AFTER transition done status: %s prev: %s", status, this.prevstatus);
   }

   @AfterTransition("done") private void Adone2() {
      writefln("\t AFTER transition 2 done status: %s prev: %s", status, this.prevstatus);
   }

   @AfterTransition("done")
   @AfterTransition("halt")
   private void Adone3() {
      writefln("\t AFTER transition 3 done status: %s prev: %s", status, this.prevstatus);
   }

   @AfterTransition("halt")
   private void Adone4() {
      writefln("\t AFTER transition 4 done status: %s prev: %s", status, this.prevstatus);
   }

   @AfterTransition("halt")
   private void Ahalt() {
      writefln("AFTER transition HALT status: %s prev: %s", status, this.prevstatus);
   }

   @BeforeTransition("idle") private void Bidle() {
      writefln("BEFORE transition idle status: %s prev: %s", status, this.prevstatus);
   }

   @AfterTransition("idle") private void Aidle() {
      writefln("AFTER transition idle status: %s prev: %s", status, this.prevstatus);
      reset();
   }

   /**
   * Riporta il sistema in idle
   *
   * Se reset e' chiamato in *AfterTransition(idle)* succede che
   * 0. Quando si entra in idle e' chiaamto Aidle
   * 1. In Aidle e' chiamato reset
   * 2. reset chiama toIdle
   * 3. si ritorna a 0
   *
   * cioe' si crea un loop.
   *
   * Per ovviare in reset si deve controlalre di non essere gia; in idle
   *
   */
   void reset() {
      writefln("RESET status %s", status);
      // !this.idle e' equivalente a (status != Status.idle)
      if (!this.idle) {
         writeln("\t toIdle");

         this.toIdle();
      }
   }
   void execute() {
      this.toIdle();
   }
}

void main() {
   /+
   auto w = new Wait();
   assert(w.status == Wait.Status.idle);
   w.toTimeout();
   assert(w.status == Wait.Status.timeout);
   writefln("prev %s", w.prevstatus());

   writeln("TO done");

   w.toDone();
   w.toDone();
   w.toDone();
   w.reset();
   w.execute();
   +/
}

unittest {
   writeln("########################################");
   auto w = new Wait();
   w.toHalt();
   writeln("########################################");
   w.toDone();
}
