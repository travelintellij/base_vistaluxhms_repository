import org.xhtmlrenderer.pdf.ITextRenderer;
import java.io.ByteArrayOutputStream;

public class TestRegex {
    public static void main(String[] args) throws Exception {
        String[] tests = {
            "<html><body>A & B</body></html>",
            "<html><body>A &amp; B</body></html>",
            "<html><body>A &#160; B</body></html>",
            "<html><body>A && B</body></html>",
            "<html><body>A & B;</body></html>",
            "<html><body>A R&D; B</body></html>",
            "<html><body><a href=\"?a=1&b=2\">link</a></body></html>",
            "<html><body>A &amp;amp; B</body></html>"
        };
        for (String test : tests) {
            String safe = test.replaceAll("&(?![A-Za-z0-9]+;|#[0-9]+;|#x[0-9a-fA-F]+;)", "&amp;");
            System.out.println("Testing: " + safe);
            try {
                ITextRenderer renderer = new ITextRenderer();
                renderer.setDocumentFromString(safe);
                renderer.layout();
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
    }
}
