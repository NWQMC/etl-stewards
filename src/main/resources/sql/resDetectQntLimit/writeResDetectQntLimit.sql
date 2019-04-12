insert
  into r_detect_qnt_lmt_swap_stewards (data_source_id,
                                       data_source,
                                       station_id,
                                       site_id,
                                       event_date,
                                       activity,
                                       analytical_method,
                                       sample_media,
                                       organization,
                                       site_type,
                                       huc,
                                       governmental_unit_code,
                                       geom,
                                       organization_name,
                                       activity_id,
                                       project_id,
                                       result_id,
                                       characteristic_name,
                                       characteristic_type,
                                       detection_limit_id,
                                       detection_limit,
                                       detection_limit_unit,
                                       detection_limit_desc)
                                select data_source_id,
                                       data_source,
                                       station_id,
                                       site_id,
                                       event_date,
                                       activity,
                                       analytical_procedure_id,
                                       sample_media,
                                       organization,
                                       site_type,
                                       huc,
                                       governmental_unit_code,
                                       geom,
                                       organization_name,
                                       activity_id,
                                       project_id,
                                       result_id,
                                       characteristic_name,
                                       characteristic_type,
                                       result_id detection_limit_id,
                                       detection_limit,
                                       detection_limit_unit,
                                       detection_limit_desc
                                  from result_swap_stewards
                                 where detection_limit is not null or
                                       detection_limit_unit is not null or
                                       detection_limit_desc is not null
