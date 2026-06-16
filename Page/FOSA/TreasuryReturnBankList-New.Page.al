page 50113 "Treasury Return Bank List-New"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Treasury Return Bank Header";
    SourceTableView = where(Status = filter(New), Posted = filter(false));
    Editable = false;
    CardPageId = 50111;

    layout
    {
        area(Content)
        {
            repeater(TreasuryRetunBank)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;

                }
                field("Bank Account Name"; Rec."Bank Account Name")
                {
                    ApplicationArea = All;

                }
                field("Bank Account Balance"; Rec."Bank Account Balance")
                {
                    ApplicationArea = All;

                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;

                }
                field("Transaction Time"; Rec."Transaction Time")
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
                Caption = 'Clear Records';
                Image = ClearLog;
                ApplicationArea = All;
                Visible = false;

                trigger OnAction();
                var
                    TR: Record "Treasury Return Bank Header";
                    TRLine: Record "Treasury Return Bank Line";
                begin
                    TR.Reset();
                    If TR.FindSet() then begin
                        TR.DeleteAll();
                    end;
                    TRLine.Reset();
                    If TRLine.FindSet() then begin
                        TRLine.DeleteAll();
                    end;
                end;
            }
        }
    }
}