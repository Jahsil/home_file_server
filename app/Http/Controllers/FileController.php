<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use File;
use Log;

class FileController extends Controller
{
    // List all files in a specific directory on your PC
    public function index()
    {
        $directory = '/var/www/html/storage/app/files'; // Direct path to the mounted directory

        if (!file_exists($directory)) {
            return response()->json(['error' => 'Directory not found'], 404);
        }

        $files = array_diff(scandir($directory), ['.', '..']);

        // return response('<h1>Welcome to the Homepage!</h1>');
        // return response()->download

        return response()->json($files);
    }

    // Download a specific file from the directory
    public function download($filename)
    {
        // Define the directory path
        $directoryPath = '/var/www/html/storage/app/files';

        // Define the full file path
        $filePath = "{$directoryPath}/{$filename}";

        // Check if the file exists
        if (File::exists($filePath)) {
            // return response()->download($filePath);
            return response()->streamDownload(function () use ($filePath) {
                // Open the file in read mode and output its contents
                $stream = fopen($filePath, 'r');
                fpassthru($stream);
                fclose($stream);
            }, $filename);
        } else {
            return response()->json(['error' => 'File not found'], Response::HTTP_NOT_FOUND);
        }
    }
}
