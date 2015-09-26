---
title: "README"
output: html_document
---

The run_analysis.R script works in four steps.

1. Load training and test data set and merge them using rbind.

2. Load feature names from features.txt, perform filtering (in this case, we keep a feature if and only if its name includes mean() or std()).  In addition, we assign proper column names to features data frame obtained in step 1.

3. Append labels and subjects to the features data frame.  Replace activity numbers with activity names.

4. Calculate mean grouped by activity and subject.