#' convert_rdata_to_csv
#'
#' Descripción de la función.
#'
#' @param rdata_file File in format RData
#' @param output_dir Destination of files converted
#' @export
#' @examples
#' convert_rdata_to_csv("/home/user/path_file_rdata", "/home/user/folder_files_csv/")
convert_rdata_to_csv <- function(rdata_file, output_dir = "./") {
  # Cargar el archivo RData
  load(rdata_file)
  all_objects <- ls()

  # Obtener la lista de todos los data frames en el entorno actual
  df_names <- all_objects[sapply(all_objects, function(obj) is.data.frame(get(obj)))]

  # Verificar si hay al menos un data frame
  if (length(df_names) == 0) {
    stop("No se encontraron data frames en el archivo RData.")
  }

  # Crear el directorio de salida si no existe
  if (!dir.exists(output_dir)) {
    dir.create(output_dir)
  }

  # Iterar sobre todos los data frames y guardarlos como archivos CSV
  for (df_name in df_names) {
    df <- get(df_name)
    csv_file <- file.path(output_dir, paste0(df_name, ".csv"))
    write.csv(df, csv_file, row.names = FALSE)
    cat("Data frame", df_name, "convertido a", csv_file, "\n")
  }
}
