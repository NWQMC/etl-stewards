/* The InstallSingleTableIT should show that a given table install works, so just create an
   environment with as few variables as possible to show every table got installed. */

/* Drop all stewards swap tables. */
drop table if exists wqp.act_metric_swap_stewards;
drop table if exists wqp.activity_sum_swap_stewards;
drop table if exists wqp.activity_swap_stewards;
drop table if exists wqp.assemblage_swap_stewards;
drop table if exists wqp.bio_hab_metric_swap_stewards;
drop table if exists wqp.char_name_swap_stewards;
drop table if exists wqp.char_type_swap_stewards;
drop table if exists wqp.country_swap_stewards;
drop table if exists wqp.county_swap_stewards;
drop table if exists wqp.ml_grouping_swap_stewards;
drop table if exists wqp.monitoring_loc_swap_stewards;
drop table if exists wqp.org_data_swap_stewards;
drop table if exists wqp.org_grouping_swap_stewards;
drop table if exists wqp.organization_sum_swap_stewards;
drop table if exists wqp.organization_swap_stewards;
drop table if exists wqp.prj_ml_weighting_swap_stewards;
drop table if exists wqp.project_data_swap_stewards;
drop table if exists wqp.project_dim_swap_stewards;
drop table if exists wqp.project_swap_stewards;
drop table if exists wqp.qwportal_summary_swap_stewards;
drop table if exists wqp.r_detect_qnt_lmt_swap_stewards;
drop table if exists wqp.result_sum_swap_stewards;
drop table if exists wqp.result_swap_stewards;
drop table if exists wqp.sample_media_swap_stewards;
drop table if exists wqp.site_type_swap_stewards;
drop table if exists wqp.state_swap_stewards;
drop table if exists wqp.station_sum_swap_stewards;
drop table if exists wqp.station_swap_stewards;
drop table if exists wqp.taxa_name_swap_stewards;

/* And replace them without indexes. */
select create_swap_table ('stewards', 'wqp', 'act_metric');
select create_swap_table ('stewards', 'wqp', 'activity_sum');
select create_swap_table ('stewards', 'wqp', 'activity');
select create_swap_table ('stewards', 'wqp', 'assemblage');
select create_swap_table ('stewards', 'wqp', 'bio_hab_metric');
select create_swap_table ('stewards', 'wqp', 'char_name');
select create_swap_table ('stewards', 'wqp', 'char_type');
select create_swap_table ('stewards', 'wqp', 'country');
select create_swap_table ('stewards', 'wqp', 'county');
select create_swap_table ('stewards', 'wqp', 'ml_grouping');
select create_swap_table ('stewards', 'wqp', 'monitoring_loc');
select create_swap_table ('stewards', 'wqp', 'org_data');
select create_swap_table ('stewards', 'wqp', 'org_grouping');
select create_swap_table ('stewards', 'wqp', 'organization_sum');
select create_swap_table ('stewards', 'wqp', 'organization');
select create_swap_table ('stewards', 'wqp', 'prj_ml_weighting');
select create_swap_table ('stewards', 'wqp', 'project_data');
select create_swap_table ('stewards', 'wqp', 'project_dim');
select create_swap_table ('stewards', 'wqp', 'project');
select create_swap_table ('stewards', 'wqp', 'r_detect_qnt_lmt');
select create_swap_table ('stewards', 'wqp', 'result_sum');
select create_swap_table ('stewards', 'wqp', 'result');
select create_swap_table ('stewards', 'wqp', 'sample_media');
select create_swap_table ('stewards', 'wqp', 'site_type');
select create_swap_table ('stewards', 'wqp', 'state');
select create_swap_table ('stewards', 'wqp', 'station_sum');
select create_swap_table ('stewards', 'wqp', 'station');
select create_swap_table ('stewards', 'wqp', 'taxa_name');

/* Drop all stewards partitions. */
drop table if exists wqp.act_metric_stewards;
drop table if exists wqp.activity_sum_stewards;
drop table if exists wqp.activity_stewards;
drop table if exists wqp.assemblage_stewards;
drop table if exists wqp.bio_hab_metric_stewards;
drop table if exists wqp.char_name_stewards;
drop table if exists wqp.char_type_stewards;
drop table if exists wqp.country_stewards;
drop table if exists wqp.county_stewards;
drop table if exists wqp.ml_grouping_stewards;
drop table if exists wqp.monitoring_loc_stewards;
drop table if exists wqp.org_data_stewards;
drop table if exists wqp.org_grouping_stewards;
drop table if exists wqp.organization_sum_stewards;
drop table if exists wqp.organization_stewards;
drop table if exists wqp.prj_ml_weighting_stewards;
drop table if exists wqp.project_data_stewards;
drop table if exists wqp.project_dim_stewards;
drop table if exists wqp.project_stewards;
drop table if exists wqp.qwportal_summary_stewards;
drop table if exists wqp.r_detect_qnt_lmt_stewards;
drop table if exists wqp.result_sum_stewards;
drop table if exists wqp.result_stewards;
drop table if exists wqp.sample_media_stewards;
drop table if exists wqp.site_type_stewards;
drop table if exists wqp.state_stewards;
drop table if exists wqp.station_sum_stewards;
drop table if exists wqp.station_stewards;
drop table if exists wqp.taxa_name_stewards;

/* And replace them without indexes. */
create table if not exists wqp.act_metric_stewards partition of wqp.act_metric for values in (0);
create table if not exists wqp.activity_sum_stewards partition of wqp.activity_sum for values in (0);
create table if not exists wqp.activity_stewards partition of wqp.activity for values in (0);
create table if not exists wqp.assemblage_stewards partition of wqp.assemblage for values in (0);
create table if not exists wqp.bio_hab_metric_stewards partition of wqp.bio_hab_metric for values in (0);
create table if not exists wqp.char_name_stewards partition of wqp.char_name for values in (0);
create table if not exists wqp.char_type_stewards partition of wqp.char_type for values in (0);
create table if not exists wqp.country_stewards partition of wqp.country for values in (0);
create table if not exists wqp.county_stewards partition of wqp.county for values in (0);
create table if not exists wqp.ml_grouping_stewards partition of wqp.ml_grouping for values in (0);
create table if not exists wqp.monitoring_loc_stewards partition of wqp.monitoring_loc for values in (0);
create table if not exists wqp.org_data_stewards partition of wqp.org_data for values in (0);
create table if not exists wqp.org_grouping_stewards partition of wqp.org_grouping for values in (0);
create table if not exists wqp.organization_sum_stewards partition of wqp.organization_sum for values in (0);
create table if not exists wqp.organization_stewards partition of wqp.organization for values in (0);
create table if not exists wqp.prj_ml_weighting_stewards partition of wqp.prj_ml_weighting for values in (0);
create table if not exists wqp.project_data_stewards partition of wqp.project_data for values in (0);
create table if not exists wqp.project_dim_stewards partition of wqp.project_dim for values in (0);
create table if not exists wqp.project_stewards partition of wqp.project for values in (0);
create table if not exists wqp.r_detect_qnt_lmt_stewards partition of wqp.r_detect_qnt_lmt for values in (0);
create table if not exists wqp.result_sum_stewards partition of wqp.result_sum for values in (0);
create table if not exists wqp.result_stewards partition of wqp.result for values in (0);
create table if not exists wqp.sample_media_stewards partition of wqp.sample_media for values in (0);
create table if not exists wqp.site_type_stewards partition of wqp.site_type for values in (0);
create table if not exists wqp.state_stewards partition of wqp.state for values in (0);
create table if not exists wqp.station_sum_stewards partition of wqp.station_sum for values in (0);
create table if not exists wqp.station_stewards partition of wqp.station for values in (0);
create table if not exists wqp.taxa_name_stewards partition of wqp.taxa_name for values in (0);

/* Make sure all _old tables exist, otherwise dbunit cries. */
create table if not exists wqp.act_metric_stewards_old (like wqp.act_metric_stewards);
create table if not exists wqp.activity_sum_stewards_old (like wqp.activity_sum_stewards);
create table if not exists wqp.activity_stewards_old (like wqp.activity_stewards);
create table if not exists wqp.assemblage_stewards_old (like wqp.assemblage_stewards);
create table if not exists wqp.bio_hab_metric_stewards_old (like wqp.bio_hab_metric_stewards);
create table if not exists wqp.char_name_stewards_old (like wqp.char_name_stewards);
create table if not exists wqp.char_type_stewards_old (like wqp.char_type_stewards);
create table if not exists wqp.country_stewards_old (like wqp.country_stewards);
create table if not exists wqp.county_stewards_old (like wqp.county_stewards);
create table if not exists wqp.ml_grouping_stewards_old (like wqp.ml_grouping_stewards);
create table if not exists wqp.monitoring_loc_stewards_old (like wqp.monitoring_loc_stewards);
create table if not exists wqp.org_data_stewards_old (like wqp.org_data_stewards);
create table if not exists wqp.org_grouping_stewards_old (like wqp.org_grouping_stewards);
create table if not exists wqp.organization_sum_stewards_old (like wqp.organization_sum_stewards);
create table if not exists wqp.organization_stewards_old (like wqp.organization_stewards);
create table if not exists wqp.prj_ml_weighting_stewards_old (like wqp.prj_ml_weighting_stewards);
create table if not exists wqp.project_data_stewards_old (like wqp.project_data_stewards);
create table if not exists wqp.project_dim_stewards_old (like wqp.project_dim_stewards);
create table if not exists wqp.project_stewards_old (like wqp.project_stewards);
create table if not exists wqp.r_detect_qnt_lmt_stewards_old (like wqp.r_detect_qnt_lmt_stewards);
create table if not exists wqp.result_sum_stewards_old (like wqp.result_sum_stewards);
create table if not exists wqp.result_stewards_old (like wqp.result_stewards);
create table if not exists wqp.sample_media_stewards_old (like wqp.sample_media_stewards);
create table if not exists wqp.site_type_stewards_old (like wqp.site_type_stewards);
create table if not exists wqp.state_stewards_old (like wqp.state_stewards);
create table if not exists wqp.station_sum_stewards_old (like wqp.station_sum_stewards);
create table if not exists wqp.station_stewards_old (like wqp.station_stewards);
create table if not exists wqp.taxa_name_stewards_old (like wqp.taxa_name_stewards);

/* Make sure all _old tables are empty. */
truncate table wqp.act_metric_stewards_old;
truncate table wqp.activity_sum_stewards_old;
truncate table wqp.activity_stewards_old;
truncate table wqp.assemblage_stewards_old;
truncate table wqp.bio_hab_metric_stewards_old;
truncate table wqp.char_name_stewards_old;
truncate table wqp.char_type_stewards_old;
truncate table wqp.country_stewards_old;
truncate table wqp.county_stewards_old;
truncate table wqp.ml_grouping_stewards_old;
truncate table wqp.monitoring_loc_stewards_old;
truncate table wqp.org_data_stewards_old;
truncate table wqp.org_grouping_stewards_old;
truncate table wqp.organization_sum_stewards_old;
truncate table wqp.organization_stewards_old;
truncate table wqp.prj_ml_weighting_stewards_old;
truncate table wqp.project_data_stewards_old;
truncate table wqp.project_dim_stewards_old;
truncate table wqp.project_stewards_old;
truncate table wqp.r_detect_qnt_lmt_stewards_old;
truncate table wqp.result_sum_stewards_old;
truncate table wqp.result_stewards_old;
truncate table wqp.sample_media_stewards_old;
truncate table wqp.site_type_stewards_old;
truncate table wqp.state_stewards_old;
truncate table wqp.station_sum_stewards_old;
truncate table wqp.station_stewards_old;
truncate table wqp.taxa_name_stewards_old;
