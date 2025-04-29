package com.xushuo.util;

import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.BaseFont;

public class PdfFontUtil {
    
    private static BaseFont baseFont;
    
    static {
        try {
            baseFont = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static Font getChineseFont(float size) {
        return new Font(baseFont, size);
    }
    
    public static Font getChineseBoldFont(float size) {
        Font font = new Font(baseFont, size);
        font.setStyle(Font.BOLD);
        return font;
    }
} 