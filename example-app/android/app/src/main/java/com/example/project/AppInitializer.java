package com.example.project;

import android.content.Context;
import android.system.ErrnoException;
import android.system.Os;

import java.io.File;


class AppInitializer {    
    static void copyAssets(Context context, String[] assetFolderNames) {
        AssetsHelper.checkExistsOrCopyFileOrDir(context, assetFolderNames);
    }

    static void copyAsset(Context context, String assetFolderName) {
        AssetsHelper.checkExistsOrCopyFileOrDir(context, assetFolderName);
    }

    static void setExecutableBit(String executableFilePath) {
        File execFile = new File(executableFilePath);
        execFile.setExecutable(true);
    }

    static void createSymbolicLink(String source, String link) throws ErrnoException {
        File linkFile = new File(link);
        if (linkFile.exists()) {
            linkFile.delete();
        }
        Os.symlink(source, link);
    }
}
