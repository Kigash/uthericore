page 50053 "Member Contribution"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Member Contribution";

    layout
    {
        area(Content)
        {
            group(Options)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                }

                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = All;
                }
            }

            repeater(Contributions)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }

                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = All;
                }

                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }

                field(Amount; Rec.Amount)
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
            action(Generate)
            {
                Caption = 'Generate Contributions';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Gen: Codeunit "Contribution Generator";
                begin

                    if EndDate = 0D then
                        Error('Please enter End Date.');
                    if EndDate < StartDate then
                        Error('End Date must be greater than Start Date.');

                    Gen.GenerateData(StartDate, EndDate);

                    Message('Contribution summary generated successfully.');
                    CurrPage.Update();
                end;
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
}