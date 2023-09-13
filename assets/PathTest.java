import java.io.*;
import java.nio.file.*;
import java.nio.file.attribute.FileTime;
import java.time.Instant;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CopyOnWriteArrayList;
import java.awt.image.BufferedImage;
import javax.imageio.*;
import javax.sound.sampled.LineListener;

public class PathTest {
    public static String programPath = new File("").getAbsolutePath();
    public static File programFile = new File(programPath);
    // public static String codePath = getDirectoryParentPath(programPath);
    public static String codePath = getDirectoryParentPath(programPath) + File.separator + "lib" +File.separator+ "code";
    public static String filelistPath = programPath + File.separator + "filelist.txt";
    public static File fileList = new File(filelistPath);
    public static List<File> imageList = new ArrayList<>();
    public static List<File> imageListSafe = Collections.synchronizedList(imageList);
    public static String[] validImageExtensions = { "png", "jpg", "jpeg", "gif", "bmp" };
    // public static List<File> exportFileList = new ArrayList<>();
    // public static List<String> exportFileNameList = new ArrayList<>();
    public static List<String> exportImgCommandList = new ArrayList<>();

    static class ImageProcessor extends Thread {
        final File imgFile;

        ImageProcessor(File imgFile) {
            this.imgFile = imgFile;
        }

        @Override
        public void run() {
            if (isImageFile(imgFile)) {
                log(imgFile.getName() + " is a Image File.");
                if (hasInvalidName(imgFile)) {
                    changeFileName(imgFile);
                    // slog("Change Img Name");
                } else {
                    slog("No need to change Img Name");
                }
                synchronized (imageListSafe) {
                    // slog("add IMAGE "+imgFile.getName()+" to ImageList");
                    imageListSafe.add(imgFile);
                }
            } else {
                log(imgFile.getName() + "is not a Image File.");
            }
        }
    }

    public static void log(String message) {
        System.out.println("[Log]: " + message);
    }

    public static void slog(String message) {
        System.out.println("[Success]: " + message);
    }

    public static void flog(String message) {
        System.out.println("[Error]: " + message);
    }

    public static void main(String args[]) {
        imageList.clear();
        File codeDir = new File(codePath);
        if (!codeDir.exists())
            codeDir.mkdirs();
        try {
            if (!fileList.exists()) {
                fileList.createNewFile();
            }
        } catch (Exception e) {
            flog("Failed to create filelist.txt");
        }
        Queue<File> queue = new LinkedList<>();
        queue.offer(programFile);
        while (!queue.isEmpty()) {
            File directory = queue.poll();
            // if(directory.isDirectory()) log("is a Dir"); else log("not a Dir");
            File[] filelist = directory.listFiles();
            List<ImageProcessor> list = new ArrayList<>();
            for (File file : filelist) {
                ImageProcessor newThread = new ImageProcessor(file);
                list.add(newThread);
                newThread.start();
                if (file.isDirectory())
                    queue.offer(file);
            }
            for (ImageProcessor imageProcessor : list) {
                try {
                    imageProcessor.join();
                } catch (Exception e) {
                    flog("Failed to stop Process");
                }
            }

            try {
                BufferedWriter bw = new BufferedWriter(new FileWriter(fileList, false));
                // log(imageList.toString());
                for (File imageFile : imageList) {
                    String asseString = getAssetsPath(imageFile);
                    bw.write("- " + asseString + "\n");
                }
                bw.close();
            } catch (Exception e) {
                flog("Failed to Write ImgFile Message to fileList");
            }
        }
        
        createDartFile();
        createImageExportDartFile();
    }

    private static boolean isImageFile(File file) {
        String name = file.getName();
        String extension = name.substring(name.lastIndexOf(".") + 1);
        for (String validImageExtension : validImageExtensions) {
            if (extension.equals(validImageExtension))
                return true;
        }
        return false;
    }

    private static boolean hasInvalidName(File file) {
        String validNameRegex = "[\\w+\\.]*";
        String oldName = file.getName();
        boolean result = oldName.matches(validNameRegex);
        return !result;
    }

    private static void changeFileName(File file) {
        String oldName = file.getName();
        String newName = oldName.replaceAll("[()]", "").replaceAll(" ", "_");
        File newFile = new File(getImgParentPath(file), newName);
        if (file.renameTo(newFile)) {
            slog("Rename File Success");
            file = newFile;
        } else {
            flog("Failed to rename File");
        }
        Path filepath = file.toPath();
        try {
            Files.setLastModifiedTime(filepath, FileTime.from(Instant.now()));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getImgParentPath(File file) {
        String absolutePath = file.getAbsolutePath();
        return absolutePath.substring(0, absolutePath.lastIndexOf(File.separator));
    }

    private static String getAssetsPath(File file) {
        String filePath = file.getAbsolutePath();
        String assetsPathInWindows =  filePath.substring(filePath.indexOf("assets"));
        return assetsPathInWindows.replaceAll("\\\\", "/");
    }

    // 下方是创建dart代码文件相关的代码
    private static void createDartFile() {
        Queue<File> queue = new LinkedList<>();
        queue.offer(programFile);
        while(!queue.isEmpty()) {
            File directory = queue.poll();
            File[] files = directory.listFiles();
            for (File file : files) {
                if(isImageFile(file)) {
                    createImageDartFile(file);
                }
                else if(file.isDirectory()&&!file.getName().equals("code")) {
                    queue.offer(file);
                }
            }
        }
    }

    private static void createDirectoryDartFile(File file) { //暂时弃用
        String fileName = file.getName();
        String className = getAttributeTypeName(fileName);
        String dartFileName = className + ".dart";
        // String dartFilePath = codePath + File.separator + dartFileName;
        File dartFile = new File(codePath,dartFileName);
        Queue<File> queue = new LinkedList<>();
        List<String> lines = new ArrayList<>();
        queue.offer(file);
        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter(dartFile,false));
            lines.add("import 'package:flutter/material.dart';\n");
            lines.add("import 'package:flame/components.dart';\n");
            lines.add("\n");
            lines.add("@immutable\n");
            lines.add("class "+className+" {\n");
            // lines.add("  "+className+"({Key?key}) : super(key:key);\n");
            while (!queue.isEmpty()) {
                File directory = queue.poll();
                File[] files = directory.listFiles();
                for (File subFile : files) {
                    if (isImageFile(subFile)) {
                        String attributeName = getAttributeName(subFile.getName());
                        lines.add("  const ImageProvider"+attributeName+" = AssetImage("+getAssetsPath(subFile)+");\n");
                    }
                    else if(subFile.isDirectory()) {
                        String attributeName = getAttributeName(subFile.getName());
                        String attributeTypeName = getAttributeTypeName(subFile.getName());
                        lines.add("  "+attributeTypeName+" "+attributeName+" = "+attributeTypeName+"();\n");
                    }
                }
            }
            lines.add("\n");
            lines.add("}\n");
            queue.offer(file);
            for (String line : lines) {
                bw.write(line);
            }
            bw.close();
        } catch (Exception e) {
            flog("Failed to create dart File");
        }
    }

    private static void createImageDartFile(File file) {
        String fileName = file.getName();
        String className = getImageClassName(fileName);
        String dartFileName = className + ".dart";
        String exportCommand = "export './"+dartFileName+"';\n";
        exportImgCommandList.add(exportCommand);
        // String dartFilePath = codePath + File.separator + dartFileName;
        File dartFile = new File(codePath,dartFileName);
        List<String> lines = new ArrayList<>();
        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter(dartFile,false));
            lines.add("import 'package:flutter/material.dart';\n");
            // lines.add("import 'package:flame/components.dart';\n");
            lines.add("\n");
            lines.add("@immutable\n");
            lines.add("class "+className+" {\n");
            // lines.add("  "+className+"({Key?key}) : super(key:key);\n");
            lines.add("  static ImageProvider image = AssetImage('"+getAssetsPath(file)+"');\n");
            // lines.add("  static String name = '"+fileName+"';\n");
            // lines.add("  static late Sprite sprite ;\n");
            // lines.add("  static Future<Sprite> loadSprite() async {\n");
            // lines.add("    return await Sprite.load('"+fileName+"');\n");
            lines.add("\n");
            lines.add("}\n");
            for (String line : lines) {
                bw.write(line);
            }
            bw.close();
        } catch (Exception e) {
            flog("Failed to create dart File");
        }
    }

    private static String getAttributeTypeName(String fileName) {
        return fileName.substring(0, 1).toUpperCase() + fileName.substring(1);
    }

    private static String getAttributeName(String fileName) {
        return fileName.substring(0,1).toLowerCase() + fileName.substring(1);
    }

    private static String getImageClassName(String fileName) {
        return fileName.substring(0,1).toUpperCase() + fileName.substring(1, fileName.lastIndexOf('.'));
    }

    private static String getDirectoryParentPath(String absolutePath) {
        return absolutePath.substring(0,absolutePath.lastIndexOf("\\"));
    }

    //导出一个AllImage.dart的文件
    private static void createImageExportDartFile() {
        String dartFileName = "all_image.dart";
        // String dartFilePath = codePath + File.separator + dartFileName;
        File dartFile = new File(codePath,dartFileName);
        List<String> lines = new ArrayList<>();
        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter(dartFile,false));
            lines.add("library all_image;\n");
            lines.add("\n");
            for (String line : lines) {
                bw.write(line);
            }
            for(String line : exportImgCommandList) {
                bw.write(line);
            }
            bw.close();
        } catch (Exception e) {
            flog("Failed to create dart File");
        }
    }
}