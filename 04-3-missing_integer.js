// https://app.codility.com/demo/results/demoRAHZDF-A5A/

// write your code in ES6 JavaScript (Node.js 8.9.4)
function solution(A) {
    let max = Math.max(...A);
    if (max <= 0) {
        return 1;
    } // Handles case of all numbers in array <= 0

    const freq = [];
    let answer;

    for (let i = 0; i < A.length; i++) {
        if (A[i] >= 0) { // Ignore all negative #s.
            freq[A[i]] = 1; // Track positive #s in frequency table.
        }
    }

    // For A = [1, 3, 6, 4, 1, 2], freq = [undefined, 1, 1, 1, 1, undefined, 1]

    for (let i = 1; i <= max; i++) { // Start with 1, since freq[0] could be undefined
        if (freq[i] === undefined) {
            answer = i;
            break;
        }
    }
    return answer || max + 1; // if answer is undefined, return max + 1
}
