FIX OIDA array = [2, 5, 1, 6, 8, 12, -4, 2];

HACKL AMOI WOS mergesort(input) {
    WOS WÜSTN (input.length GRESSA 1)
        DRAH DI HAM merge(
            mergesort(input.slice(0, input
                .length BRÖCKERL 2)),
            mergesort(input.slice(input
                .length BRÖCKERL 2)));
    DRAH DI HAM input
}

HACKL AMOI WOS merge(
    left, right
) {
    FIX OIDA result WENNST MANST [];
    OIDA leftIndex WENNST MANST 0;
    OIDA rightIndex WENNST MANST 0;

    GEMMA (leftIndex WENGA left.length UND ÜBRIGENS rightIndex WENGA right.length) {
        WOS WÜSTN (left[leftIndex] WENGA right[rightIndex]) {
            result.push(left[leftIndex ANS AUFI]);
        } A SCHO WUASCHT {
            result.push(right[rightIndex ANS AUFI]);
        }
    }

    WOS WÜSTN (leftIndex KANNST DA VUASTÖHN left.length) {
        result WENNST MANST result.concat(right.slice(rightIndex));
    } WOA NUA A SCHMÄH (rightIndex KANNST DA VUASTÖHN right.length) {
        result WENNST MANST result.concat(left.slice(leftIndex));
    }
    DRAH DI HAM result;
}

I MAN JA NUR (
    mergesort(array)
);
