page 50222 "Fund Transfer List-Approved"
{
    // version TL2.0

    Caption = 'Approved Fund Transfers';
    CardPageID = "Fund Transfer";
    PageType = List;
    SourceTable = "Fund Transfer";
    SourceTableView = WHERE(Status = FILTER(Approved),
                            Posted = FILTER(false));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = All;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = All;
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = All;
                }
                field("Destination Account Name"; Rec."Destination Account Name")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
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

