# Contributing to DataLab

Thank you for helping improve DataLab. Contributions should strengthen the archive while respecting copyright, privacy, course rules, and academic integrity.

## What you can contribute

- Corrections to documentation, tables, labels, and links
- Missing or improved attribution
- Fixes for broken or incorrectly packaged archives
- Course materials that you created or have permission to share
- Original implementations that may be shared under the applicable course rules

## Contribution requirements

### Share only authorized material

Submit only files that you created, that are already distributed under terms permitting redistribution, or that you have explicit permission to share. Do not submit private course content, leaked material, copyrighted works from unrelated sources, or files with unclear ownership.

### Protect academic integrity

Do not contribute answers or implementations for active graded assignments when publication would violate course or institutional rules. Never present another person's work as your own.

### Preserve attribution

Keep existing copyright notices, license files, author credits, and source references intact. In your pull request, identify the source and original author of any material you did not create yourself.

### Remove sensitive information

Before submitting, remove API keys, passwords, access tokens, private URLs, student records, personal information, and other secrets. Review both source files and generated configuration files.

## Repository organization

Place files in the appropriate course, category, and semester directory. Follow the existing structure whenever possible:

```text
Database/
  Homework/Spring_YYYY/
  Project/Spring_YYYY/

Software_Studio/
  Examples/Spring_YYYY/
  Labs/Spring_YYYY/
  Solutions/Spring_YYYY/
```

Use descriptive filenames consistent with neighboring files. Preserve the `Spring_YYYY` semester format and use two-digit assignment numbers such as `HW01` or `Lab01`.

## Archive and link checks

Before submitting:

1. Confirm that every ZIP archive opens successfully.
2. Remove unnecessary build output, caches, credentials, and personal files.
3. Verify that README download references match the exact filename and directory path.
4. Use the `Fincarson/DataLab` repository path for raw GitHub download links.
5. Keep GitLab links in the existing `[Download] ([GitLab])` format when both links are available.

## Pull requests

Keep each pull request focused on one course, semester, or type of correction. In the description, explain:

- What was added or changed
- Which course and semester it belongs to
- Where the material came from
- Why you are authorized to share it
- How you verified the archives and links

By submitting a contribution, you confirm that you have the right to share it and that doing so complies with the applicable course and institutional policies.
