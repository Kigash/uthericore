page 50295 "Member Remittance Advice List"
{
    // version TL2.0

    Caption = 'Member Remittance Advice';
    CardPageID = "Member Remittance Advice";
    PageType = List;
    SourceTable = "Member Remittance Header";
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
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Time"; Rec."Last Modified Time")
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

