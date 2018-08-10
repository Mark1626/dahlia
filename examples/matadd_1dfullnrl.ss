/////////////////////////////////////////////
// matrix add with one dimension fully unrolled
// - This application uses one banked array as input,
// one banked array as output, regular banking with each
// unroll accessing different bank, matrix access explicitly
// and all matrices being of same parameters.
// * This example was added to test a common but specific case
// where even though static component seems dynamic, it is
// in fact static allowing access with a variable.
////////////////////////////////////////////

func madd(a: float[1024 bank(32)], b: float[1024 bank(32)], c: float[1024 bank(32)]) {

  for (let i = 0..31) {
    for (let j = 0..31) unroll 32 {
      c{j}[i] := a{j}[i] + b{j}[i];
    } 
  } 

}