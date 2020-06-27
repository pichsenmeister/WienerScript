HACKL AMOI WOS calc(operator, left, right) {
    WOS IS MIT DIR (operator) {
        I SCHAU NUR '+':
            DRAH DI HAM left AUFI right
        I SCHAU NUR '-':
            DRAH DI HAM left OWI right   
        I SCHAU NUR '*':
            DRAH DI HAM left HAUTS EICH ZAM right   
        I SCHAU NUR '/':
            DRAH DI HAM left BRÖCKERL right
        NA GEH:
            GEH SCHEISSN ('invalid operator')          
    }

    DRAH DI HAM sum
}

SCHAU MA MOL {
    I MAN JA NUR (calc('+', 1, 2))
} LECK OASCH (err) {
    GSCHISSN GRISSN ('invalid operation')
}