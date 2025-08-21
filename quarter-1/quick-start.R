# Quick Start Script for Tidying & Wrangling Data Presentation
# Run this script to set up and render your Quarto RevealJS presentation

# Load required libraries
if (!require("quarto")) install.packages("quarto")
if (!require("rmarkdown")) install.packages("rmarkdown")

library(quarto)
library(rmarkdown)

# Function to check if Quarto is installed properly
check_quarto_installation <- function() {
  cat("Checking Quarto installation...\n")
  
  # Check if quarto command is available
  tryCatch({
    system("quarto --version", intern = TRUE)
    cat("✓ Quarto is properly installed\n")
    return(TRUE)
  }, error = function(e) {
    cat("✗ Quarto not found. Please install from https://quarto.org/\n")
    return(FALSE)
  })
}

# Function to render the presentation
render_presentation <- function(filename = "tidying-wrangling-data.qmd") {
  cat("Rendering presentation...\n")
  
  if (!file.exists(filename)) {
    cat("✗ File", filename, "not found in current directory\n")
    cat("Make sure you have the .qmd file in your working directory\n")
    return(FALSE)
  }
  
  tryCatch({
    quarto_render(filename)
    cat("✓ Presentation rendered successfully!\n")
    cat("The HTML file should have opened in your browser\n")
    return(TRUE)
  }, error = function(e) {
    cat("✗ Error rendering presentation:", e$message, "\n")
    return(FALSE)
  })
}

# Function to preview the presentation in RStudio
preview_presentation <- function(filename = "tidying-wrangling-data.qmd") {
  cat("Starting preview mode...\n")
  
  if (!file.exists(filename)) {
    cat("✗ File", filename, "not found in current directory\n")
    return(FALSE)
  }
  
  tryCatch({
    quarto_preview(filename)
    cat("✓ Preview started! The presentation will auto-update when you save changes\n")
    return(TRUE)
  }, error = function(e) {
    cat("✗ Error starting preview:", e$message, "\n")
    return(FALSE)
  })
}

# Function to export to different formats
export_presentation <- function(filename = "tidying-wrangling-data.qmd", format = "html") {
  cat("Exporting presentation to", format, "format...\n")
  
  valid_formats <- c("html", "pdf", "pptx")
  if (!format %in% valid_formats) {
    cat("✗ Invalid format. Choose from:", paste(valid_formats, collapse = ", "), "\n")
    return(FALSE)
  }
  
  if (!file.exists(filename)) {
    cat("✗ File", filename, "not found in current directory\n")
    return(FALSE)
  }
  
  tryCatch({
    if (format == "html") {
      quarto_render(filename, output_format = "revealjs")
    } else {
      quarto_render(filename, output_format = format)
    }
    cat("✓ Exported to", format, "successfully!\n")
    return(TRUE)
  }, error = function(e) {
    cat("✗ Error exporting:", e$message, "\n")
    return(FALSE)
  })
}

# Main execution
main <- function() {
  cat("=== Quarto RevealJS Presentation Quick Start ===\n\n")
  
  # Check installation
  if (!check_quarto_installation()) {
    return()
  }
  
  # Check for required files
  files_needed <- c("tidying-wrangling-data.qmd", "custom.scss")
  missing_files <- files_needed[!file.exists(files_needed)]
  
  if (length(missing_files) > 0) {
    cat("✗ Missing required files:\n")
    for (file in missing_files) {
      cat("  -", file, "\n")
    }
    cat("\nPlease ensure all required files are in your working directory\n")
    cat("Current working directory:", getwd(), "\n")
    return()
  }
  
  cat("✓ All required files found\n\n")
  
  # Menu for user choice
  cat("Choose an action:\n")
  cat("1. Render presentation (create HTML file)\n")
  cat("2. Start preview mode (auto-updates on save)\n")
  cat("3. Export to PowerPoint (PPTX)\n")
  cat("4. Show presentation info\n")
  cat("5. Exit\n\n")
  
  choice <- readline(prompt = "Enter your choice (1-5): ")
  
  switch(choice,
    "1" = render_presentation(),
    "2" = preview_presentation(),
    "3" = export_presentation(format = "pptx"),
    "4" = show_presentation_info(),
    "5" = cat("Goodbye!\n"),
    cat("Invalid choice. Please run the script again.\n")
  )
}

# Function to show presentation information
show_presentation_info <- function() {
  cat("\n=== Presentation Information ===\n")
  cat("Title: Tidying & Wrangling Data\n")
  cat("Subtitle: tidyr, purrr, stringr, forcats\n")
  cat("Format: Quarto RevealJS\n")
  cat("Theme: Custom (with custom.scss)\n\n")
  
  cat("Key Features:\n")
  cat("- Interactive navigation\n")
  cat("- Syntax-highlighted R code\n")
  cat("- Incremental bullet points\n")
  cat("- Speaker notes\n")
  cat("- Chalkboard drawing\n")
  cat("- Responsive design\n\n")
  
  cat("Navigation Shortcuts:\n")
  cat("- Next slide: → (arrow), Space, N\n")
  cat("- Previous slide: ← (arrow), P\n")
  cat("- Fullscreen: F\n")
  cat("- Overview: O\n")
  cat("- Speaker view: S\n")
  cat("- Chalkboard: B\n\n")
  
  if (file.exists("tidying-wrangling-data.html")) {
    cat("✓ HTML presentation file exists\n")
  } else {
    cat("✗ HTML presentation not yet rendered\n")
  }
}

# Additional helper functions
setup_project <- function() {
  cat("Setting up new Quarto presentation project...\n")
  
  # Create necessary directories
  if (!dir.exists("images")) {
    dir.create("images")
    cat("✓ Created images directory\n")
  }
  
  if (!dir.exists("data")) {
    dir.create("data")
    cat("✓ Created data directory\n")
  }
  
  # Create a basic .gitignore if it doesn't exist
  if (!file.exists(".gitignore")) {
    gitignore_content <- c(
      "# Quarto files",
      "/.quarto/",
      "*.html",
      "",
      "# R files", 
      ".Rproj.user/",
      ".Rhistory",
      ".RData",
      ".Ruserdata",
      "",
      "# OS files",
      ".DS_Store",
      "Thumbs.db"
    )
    writeLines(gitignore_content, ".gitignore")
    cat("✓ Created .gitignore file\n")
  }
  
  cat("Project setup complete!\n")
}

# Print helpful tips
print_tips <- function() {
  cat("\n=== Helpful Tips ===\n")
  cat("1. Use 'Render on Save' option in RStudio for automatic updates\n")
  cat("2. Press 'F' in presentation mode for fullscreen\n")
  cat("3. Use speaker view (S) for notes and timer\n")
  cat("4. Customize colors by editing CSS variables in custom.scss\n")
  cat("5. Add new slides with '## Slide Title' in the .qmd file\n")
  cat("6. Use fragments for incremental reveals: ::: {.fragment}\n\n")
}

# Run the main function if script is executed directly
if (interactive()) {
  main()
} else {
  cat("Quarto RevealJS Presentation Quick Start Script Loaded\n")
  cat("Run main() to start the interactive menu\n")
  cat("Or use individual functions like render_presentation()\n")
}