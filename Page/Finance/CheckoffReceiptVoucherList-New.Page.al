page 50632 "Checkoff Rct. Voucher List-New"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Checkoff Receipt Header";
    CardPageId = 50630;
    SourceTableView = WHERE(Status = FILTER(New),
                            Posted = filter(false));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;

                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;

                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;

                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                }
                field("Total Line Amount"; Rec."Total Line Amount")
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
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}