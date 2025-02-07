document.addEventListener('DOMContentLoaded', () => {
    // Elements
    const filterBtn = document.getElementById('filter-btn');
    const sortAscBtn = document.getElementById('sort-asc');
    const sortDescBtn = document.getElementById('sort-desc');
    const calculateBtn = document.getElementById('calculate');
    const resetBtn = document.getElementById('reset');
    const productsGrid = document.querySelector('.products-grid');

    // Validation functions
    function validateTextInput(input) {
        return input.value.trim().length > 0 && !/^\d+$/.test(input.value);
    }

    function validateFilters() {
        const searchInput = document.getElementById('search');
        const descriereInput = document.getElementById('descriere');
        
        if (searchInput.value.trim() && !validateTextInput(searchInput)) {
            alert('Textul de căutare nu poate conține doar numere');
            return false;
        }

        if (descriereInput.value.trim() && !validateTextInput(descriereInput)) {
            alert('Descrierea nu poate conține doar numere');
            return false;
        }

        return true;
    }

    // Filter products
    filterBtn.addEventListener('click', () => {
        if (!validateFilters()) return;
        
        const products = document.querySelectorAll('.product-card');
        const searchValue = document.getElementById('search').value.toLowerCase();
        const priceValue = parseFloat(document.getElementById('price').value);
        const tipProdusValue = document.querySelector('input[name="tip_produs"]:checked').value;
        const ambalajValue = document.getElementById('ambalaj').value;
        const selectedIngrediente = Array.from(document.getElementById('ingrediente').selectedOptions).map(opt => opt.value);
        const selectedMonths = Array.from(document.getElementById('months').selectedOptions).map(opt => parseInt(opt.value));
        const showDiscount = document.getElementById('discount').checked;
        const descriereValue = document.getElementById('descriere').value.toLowerCase();

        products.forEach(product => {
            const productContainer = product.closest('.col');
            let show = true;

            // Apply filters
            if (searchValue && !product.textContent.toLowerCase().includes(searchValue)) {
                show = false;
            }

            if (show && tipProdusValue !== 'all' && product.dataset.tipProdus !== tipProdusValue) {
                show = false;
            }

            const price = parseFloat(product.querySelector('.price').textContent);
            if (show && price > priceValue) {
                show = false;
            }

            if (show && showDiscount && price <= 50) {
                show = false;
            }

            if (show && ambalajValue && product.dataset.ambalaj !== ambalajValue) {
                show = false;
            }

            if (show && selectedIngrediente.length > 0) {
                const productIngrediente = product.dataset.ingrediente.split(',');
                if (!selectedIngrediente.some(ing => productIngrediente.includes(ing))) {
                    show = false;
                }
            }

            if (show && selectedMonths.length > 0) {
                const productDate = new Date(product.querySelector('time').dateTime);
                if (!selectedMonths.includes(productDate.getMonth() + 1)) {
                    show = false;
                }
            }

            if (show && descriereValue) {
                const description = product.querySelector('.description').textContent.toLowerCase();
                if (!description.includes(descriereValue)) {
                    show = false;
                }
            }

            productContainer.style.display = show ? '' : 'none';
        });
    });

    // Sort products
    function sortProducts(ascending = true) {
        const products = Array.from(document.querySelectorAll('.col'));
        const sorted = products.sort((a, b) => {
            const priceA = parseFloat(a.querySelector('.price').textContent);
            const priceB = parseFloat(b.querySelector('.price').textContent);
            const ingredienteA = a.querySelector('[data-ingrediente]').dataset.ingrediente.split(',').length;
            const ingredienteB = b.querySelector('[data-ingrediente]').dataset.ingrediente.split(',').length;
            
            if (priceA === priceB) {
                return ascending ? ingredienteA - ingredienteB : ingredienteB - ingredienteA;
            }
            return ascending ? priceA - priceB : priceB - priceA;
        });

        productsGrid.innerHTML = '';
        sorted.forEach(product => productsGrid.appendChild(product));
    }

    sortAscBtn.addEventListener('click', () => sortProducts(true));
    sortDescBtn.addEventListener('click', () => sortProducts(false));

    // Calculate average price
    calculateBtn.addEventListener('click', () => {
        const visibleProducts = Array.from(document.querySelectorAll('.product-card'))
            .filter(p => p.closest('.col').style.display !== 'none');
        
        if (visibleProducts.length === 0) {
            alert('Nu există produse vizibile pentru a calcula media prețurilor.');
            return;
        }

        const total = visibleProducts.reduce((sum, product) => {
            return sum + parseFloat(product.querySelector('.price').textContent);
        }, 0);
        const average = total / visibleProducts.length;

        // Remove any existing calculation result
        const existingResult = document.querySelector('.calculation-result');
        if (existingResult) {
            existingResult.remove();
        }

        const resultDiv = document.createElement('div');
        resultDiv.className = 'calculation-result';
        resultDiv.textContent = `Preț mediu: ${average.toFixed(2)} RON`;
        
        document.body.appendChild(resultDiv);
        setTimeout(() => resultDiv.remove(), 3000);
    });

    // Reset filters
    resetBtn.addEventListener('click', () => {
        if (confirm('Sigur doriți să resetați toate filtrele?')) {
            // Reset all form inputs
            document.getElementById('search').value = '';
            document.getElementById('price').value = 100;
            document.querySelector('input[name="tip_produs"][value="all"]').checked = true;
            document.getElementById('ambalaj').value = '';
            document.getElementById('ingrediente').selectedIndex = -1;
            Array.from(document.getElementById('months').options).forEach(opt => opt.selected = true);
            document.getElementById('discount').checked = false;
            document.getElementById('descriere').value = '';

            // Show all products
            document.querySelectorAll('.col').forEach(product => {
                product.style.display = '';
            });

            // Update price range display
            document.querySelector('.current').textContent = '100 RON';
        }
    });

    // Update price range display
    const priceRange = document.getElementById('price');
    const currentPrice = document.querySelector('.current');
    priceRange.addEventListener('input', () => {
        currentPrice.textContent = `${priceRange.value} RON`;
    });
    // Initial price display
    currentPrice.textContent = `${priceRange.value} RON`;
});