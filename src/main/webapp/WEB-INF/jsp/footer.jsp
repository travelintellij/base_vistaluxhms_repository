<%--=====AI MODIFICATION START=====Change: Created a proper footer with Grand Suite styling Reason: Old footer was empty
    (just closing tags). New footer adds a professional branded bar. Scope: Global footer — affects all pages that
    include this file --%>

    <!-- ===== FOOTER ===== -->
    <footer class="gs-footer">
        <span>&copy; 2026 <span class="gs-footer-brand">AxisHMS Pro</span> &mdash; Premium Hotel Management
            System</span>
    </footer>

    <%--=====AI MODIFICATION END=====--%>

        <%--=====OLD FOOTER CODE (preserved for reference)=====<!--this is footer , should be okay -->
            ===== END OLD FOOTER CODE ===== --%>
            
<script>
document.addEventListener("DOMContentLoaded", function() {
    var inputs = document.querySelectorAll('input, select, textarea');
    inputs.forEach(function(el) {
        var isRequired = el.hasAttribute('required') && el.getAttribute('required') !== 'false';
        if (isRequired) {
            var label = null;
            
            // Special handling for grouped radios/checkboxes
            var radioContainer = el.closest('.radio-group-container');
            if (radioContainer) {
                label = radioContainer.querySelector('label');
            } else {
                if (el.id) {
                    label = document.querySelector('label[for="' + el.id + '"]');
                }
                if (!label) {
                    var formGroup = el.closest('.form-group');
                    if (formGroup) {
                        // Find a label that is not wrapping a radio/checkbox
                        var labels = formGroup.querySelectorAll('label');
                        for (var i = 0; i < labels.length; i++) {
                             if (!labels[i].querySelector('input')) {
                                  label = labels[i];
                                  break;
                             }
                        }
                        if (!label && labels.length > 0) label = labels[0];
                    }
                }
                if (!label && el.previousElementSibling && el.previousElementSibling.tagName === 'LABEL') {
                    label = el.previousElementSibling;
                }
                
                // Final fallback using parent element
                if (!label && el.parentElement && el.parentElement.tagName === 'LABEL') {
                    // But we shouldn't append star to the wrapper unless it has text. 
                    // Let's just use it cautiously.
                }
            }
            
            if (label && !label.querySelector('.required-star')) {
                // Ensure it doesn't already have a *.
                if (!label.innerText.includes('*')) {
                    var star = document.createElement("span");
                    star.className = "required-star";
                    star.style.color = "red";
                    star.innerHTML = " *";
                    label.appendChild(star);
                }
            }
        }
    });
});
</script>
</body>

            </html>