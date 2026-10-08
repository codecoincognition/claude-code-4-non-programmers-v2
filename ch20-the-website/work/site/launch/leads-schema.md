# Notion Leads database — schema

| Property      | Type      | Used for                              |
|---------------|-----------|---------------------------------------|
| Name          | Title     | Lead's full name                      |
| Email         | Email     | Lead's email (unique-ish; not enforced) |
| Company       | Text      | Lead's company                        |
| Submitted At  | Date      | Server timestamp at write             |
| Source        | Text      | Which page/campaign captured them     |
| Status        | Select    | New | Contacted | Registered | Cold   |

Once you apply Ch 9's make-it-yours #6, Iris reads this DB the morning after each capture and drafts personalized follow-ups in Maya's voice. Reuben (Ch 11) rolls leads up by Source at month-end. Apply Ch 12's make-it-yours fourth-category extension and Echo also reconciles this DB against the main CRM, flagging leads that never got promoted.
