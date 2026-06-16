page 50013 "Member Application Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Member Application Setup";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Phone No. Format"; Rec."Phone No. Format")
                {
                    ApplicationArea = All;
                }

                field("Member No. Format"; Rec."Member No. Format")
                {
                    ApplicationArea = All;
                }
                field("MA Individual Nos."; Rec."MA Individual Nos.")
                {
                    ApplicationArea = All;
                }
                field("MA Group Nos."; Rec."MA Group Nos.")
                {
                    ApplicationArea = All;
                }
                field("MA Company Nos."; Rec."MA Company Nos.")
                {
                    ApplicationArea = All;
                }
                field("MA Joint Nos."; Rec."MA Joint Nos.")
                {
                    ApplicationArea = All;
                }
                field("Member Nos."; Rec."Member Nos.")
                {
                    ApplicationArea = All;
                }
                field("Group Member Nos."; Rec."Group Member Nos.")
                {
                    ApplicationArea = All;
                }
                field("Enforce 18 Years and Above"; Rec."Enforce 18 Years and Above")
                {
                    ApplicationArea = All;
                }
                field("Registration Fee"; Rec."Registration Fee")
                {
                    ApplicationArea = All;
                }

            }
            group(Notification)
            {
                field("Notify Member"; Rec."Notify Member")
                {
                    ApplicationArea = All;
                }
                field("Email Template (PendingApprov)"; Rec."Email Template (PendingApprov)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (PendingApprov)"; Rec."SMS Template (PendingApprov)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Email Template (Approved)"; Rec."Email Template (Approved)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Approved)"; Rec."SMS Template (Approved)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Email Template (Additional)"; Rec."Email Template (Additional)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Additional)"; Rec."SMS Template (Additional)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Dormancy)"; Rec."SMS Template (Dormancy)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Notification Channel"; Rec."Notification Channel")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Registration (Account Type)"; Rec."Registration (Account Type)")
                {
                    ApplicationArea = All;
                }
                field("Registration Fee Posting Group"; Rec."Registration Fee Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Registration Fee Template Name"; Rec."Registration Fee Template Name")
                {
                    ApplicationArea = All;
                }
                field("Registration Fee Batch Name"; Rec."Registration Fee Batch Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

