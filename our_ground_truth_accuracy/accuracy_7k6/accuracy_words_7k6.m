clear all
close all

load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/ground_truth_words.mat;
load /home/hxu1/lsda/youtube_experiment/data/accuracy_data/topk_from_7k6/topk_cats_7k6.mat;

% compute binary accuracy
max_top1_accuracy=binary_accuracy(ground_truth_words,max_top1_cats);
max_top5_accuracy=binary_accuracy(ground_truth_words,max_top5_cats);
max_top10_accuracy=binary_accuracy(ground_truth_words,max_top10_cats);

avg_top1_accuracy=binary_accuracy(ground_truth_words,avg_top1_cats);
avg_top5_accuracy=binary_accuracy(ground_truth_words,avg_top5_cats);
avg_top10_accuracy=binary_accuracy(ground_truth_words,avg_top10_cats);

fprintf('\nbinary accuracy:');
fprintf('\nmax_top1_accuracy: %.3f',max_top1_accuracy);
fprintf('\nmax_top5_accuracy: %.3f',max_top5_accuracy);
fprintf('\nmax_top10_accuracy: %.3f',max_top10_accuracy);
fprintf('\n\navg_top1_accuracy: %.3f',avg_top1_accuracy);
fprintf('\navg_top5_accuracy: %.3f',avg_top5_accuracy);
fprintf('\navg_top10_accuracy: %.3f\n',avg_top10_accuracy);


% compute recall average
max_top1_recall_avg=recall_average(ground_truth_words,max_top1_cats);
max_top5_recall_avg=recall_average(ground_truth_words,max_top5_cats);
max_top10_recall_avg=recall_average(ground_truth_words,max_top10_cats);

avg_top1_recall_avg=recall_average(ground_truth_words,avg_top1_cats);
avg_top5_recall_avg=recall_average(ground_truth_words,avg_top5_cats);
avg_top10_recall_avg=recall_average(ground_truth_words,avg_top10_cats);

fprintf('\nrecall average:');
fprintf('\nmax_top1_recall_avg: %.3f',max_top1_recall_avg);
fprintf('\nmax_top5_recall_avg: %.3f',max_top5_recall_avg);
fprintf('\nmax_top10_recall_avg: %.3f',max_top10_recall_avg);
fprintf('\n\navg_top1_recall_avg: %.3f',avg_top1_recall_avg);
fprintf('\navg_top5_recall_avg: %.3f',avg_top5_recall_avg);
fprintf('\navg_top10_recall_avg: %.3f\n',avg_top10_recall_avg);