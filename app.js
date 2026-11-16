document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('[data-clear]').forEach((button) => {
        button.addEventListener('click', () => {
            const form = button.closest('form');
            if (form) {
                form.reset();
            }
        });
    });

    const currentYear = new Date().getFullYear();
    const footerYear = document.querySelector('[data-year]');
    if (footerYear) {
        footerYear.textContent = currentYear;
    }
});
