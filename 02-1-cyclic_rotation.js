function whereItGoes(start, K, arrayLength) {
  var K = K % arrayLength;
  if (start + K < arrayLength)
      return start + K;
  else
      return start + K - arrayLength;
}

function solution(A, K) {
  var len = A.length;
  if (len === 0 || len === 1) return A;
  var destination = whereItGoes(0, K, len);
  var slicenum = len - destination;
  A = A.slice(slicenum).concat(A.slice(0, slicenum))
  return A;
}

// Ruby answer: too simple!
// def solution(a, k)
//   a.rotate(-k)
// end