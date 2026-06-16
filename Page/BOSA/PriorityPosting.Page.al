page 50291 "Priority Posting"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Priority Posting";
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(PriorityPosting)
            {

                field("Priority Type"; Rec."Priority Type")
                {
                    ApplicationArea = All;
                }
                field("Priority Code"; Rec."Priority Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Deduction Type"; Rec."Deduction Type")
                {
                    ApplicationArea = All;
                }
                field("Calculatation Type"; Rec."Calculation Type")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field("Overdraw Savings"; Rec."Overdraw Savings")
                {
                    ApplicationArea = All;
                }
            }
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