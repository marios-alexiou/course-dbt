# Welcome my dbt project!
## These are the answers for the project of week #4!
### (Part 2) Modeling challenge

- How are our users moving through the product funnel?

- Which steps in the funnel have largest drop off points?

```
WITH cte AS
(
	SELECT  'total_sessions'                                                               AS funnel_stage
	       ,COUNT(distinct CASE WHEN event_type='page_view' THEN session_id ELSE null END) AS count_of_records
	FROM dbt.dbt_marios_a.fact_events
	UNION ALL
	SELECT  'add_to_cart'
	       ,COUNT(distinct CASE WHEN event_type='add_to_cart' THEN session_id ELSE null END) AS total_sessions
	FROM dbt.dbt_marios_a.fact_events
	UNION ALL
	SELECT  'checkout'
	       ,COUNT(distinct CASE WHEN event_type='checkout' THEN session_id ELSE null END) AS total_sessions
	FROM dbt.dbt_marios_a.fact_events
), calculation_step AS
(
	SELECT  *
	       ,lag(count_of_records) over () AS count_of_records_previous_stage
	FROM cte
)
SELECT  *
       ,coalesce(count_of_records - count_of_records_previous_stage ,0 ) lost_customers
FROM calculation_step

```
### (Part 3) Reflection questions 

- 3a : Currently my organisation has started migrating workflows to dbt, and we are pushing to this change. 
The main reason that made me choose this course was because of this migration and I ended up falling in love with dbt.. :) 
Something we will definately use in my org that we currently have not set up are the snapshots, which I find highly valuable to our analysis.

- 3b: Regarding the scheduling part of the answer, I will say that I would use ARGO, a kubernetes tool that we currently use in my org and is the scheduling orchestration tool. 
Other than that I am not quite sure of how I would set up the production run of the dbt just yet! Something I will definately dive deeper.