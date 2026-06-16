page 55234 "Member Savings With-Approved"
{
    // version TL2.0

    Caption = 'Approved Member Savings Withdrawal';
    CardPageID = "Member Savings Withdrawal";
    Editable = false;
    PageType = List;
    SourceTable = "Member Exit Header";
    SourceTableView = WHERE(Status = FILTER(Approved), Posted = const(false), "Exit Type" = filter("Temporary Exit"));
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Approved Time"; Rec."Approved Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

