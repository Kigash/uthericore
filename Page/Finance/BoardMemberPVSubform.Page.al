page 56604 "Board Member PV Subform"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Board Members Payment Line";
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sitting Allowance"; Rec."Sitting Allowance")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Sitting Allowance Tax"; Rec."Sitting Allowance Tax")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transport Allowance"; Rec."Transport Allowance")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Hospitality; Rec.Hospitality)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Gross Pay"; Rec."Gross Pay")
                {
                    ApplicationArea = All;
                }
                field("Net Pay"; Rec."Net Pay")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Suggest Lines")
            {
                Image = SuggestLines;
                Visible = false;

                trigger OnAction();
                begin
                    //CashManagement.SuggestPaymentLines(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin

    end;

    var
        CashManagement: Codeunit "Cash Management";

}
