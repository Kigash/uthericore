page 50492 "Separation Card"
{
    Caption = 'Separation Form';
    PageType = Card;
    SourceTable = Separation;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Separation Date"; Rec."Separation Date")
                {
                    ApplicationArea = All;
                }
                field("Separation Type"; Rec."Separation Type")
                {
                    ApplicationArea = All;
                }
                field("Notification Start Date"; Rec."Notification Start Date")
                {
                    ApplicationArea = All;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Notification End Date"; Rec."Notification End Date")
                {
                    ApplicationArea = All;
                }
                field("Last Working Date"; Rec."Last Working Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Accrual End Date"; Rec."Leave Accrual End Date")
                {
                    ApplicationArea = All;
                }
                field("Days In Lieu of Notice"; Rec."Days In Lieu of Notice")
                {
                    ApplicationArea = All;
                }
                field("Reason for Separation"; Rec."Reason for Separation")
                {
                    ApplicationArea = All;
                }
                field("Separation Status"; Rec."Separation Status")
                {
                    ApplicationArea = All;
                }
            }
            group("Leave Days")
            {
                Caption = 'Leave Days';
                Visible = SeeTerminalDues;
                field("Leave Balance"; Rec."Leave Days Earned to Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Days in Notice"; Rec."Leave Days in Notice")
                {
                    ApplicationArea = All;
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    ApplicationArea = All;
                }
                field("Leave End Date"; Rec."Leave End Date")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Leave Days"; Rec."Outstanding Leave Days")
                {
                    ApplicationArea = All;
                }
                field("Pay for Outstanding Leave Days"; Rec."Pay for Outstanding Leave Days")
                {
                    ApplicationArea = All;
                }
            }
            group(Salary)
            {
                Caption = 'Salary';
                Visible = SeeTerminalDues;
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ApplicationArea = All;
                }
                field("No. Of Months Salary"; Rec."No. Of Months Salary")
                {
                    ApplicationArea = All;
                }
                field("No. Full Months Worked"; Rec."Salary For Full Month")
                {
                    ApplicationArea = All;
                }
                field("Extra Days Worked"; Rec."Salary For Extra Days")
                {
                    ApplicationArea = All;
                }
                field("Part Salary Start Date"; Rec."Part Salary Start Date")
                {
                    ApplicationArea = All;
                }
                field("Part Salary End Date"; Rec."Part Salary End Date")
                {
                    ApplicationArea = All;
                }
                field("Part Salary to be paid"; Rec."Part Salary to be paid")
                {
                    ApplicationArea = All;
                }
            }
            group(Allowances)
            {
                Caption = 'Allowances';
                Visible = SeeTerminalDues;
                field("Golden Handshake"; Rec."Golden Handshake")
                {
                    ApplicationArea = All;
                }
                field("Transport Allowance"; Rec."Transport Allowance")
                {
                    ApplicationArea = All;
                }
                field("No of Years Worked"; Rec."No of Years Worked")
                {
                    ApplicationArea = All;
                }
                field("Severence Pay"; Rec."Severence Pay")
                {
                    ApplicationArea = All;
                }
                field("Pay Leave Allowance"; Rec."Pay Leave Allowance")
                {
                    ApplicationArea = All;
                }
                field("Leave Allowance Paid"; Rec."Leave Allowance Paid")
                {
                    ApplicationArea = All;
                }
                field("Pay Car Allowance"; Rec."Pay Car Allowance")
                {
                    ApplicationArea = All;
                }
                field("No of Months Car Allowance"; Rec."No of Months Car Allowance")
                {
                    ApplicationArea = All;
                }
                field("Car Allowance(Months)"; Rec."Car Allowance(Months)")
                {
                    ApplicationArea = All;
                }
                field("No of Days for Car Allowance"; Rec."No of Days for Car Allowance")
                {
                    ApplicationArea = All;
                }
                field("Car Allowance"; Rec."Car Allowance")
                {
                    ApplicationArea = All;
                }
            }
            group(Totals)
            {
                Caption = 'Totals';
                Visible = SeeTerminalDues;
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(PAYE)
            {
                Caption = 'PAYE';
                Visible = SeeTerminalDues;
                field("PAYE Due"; Rec."PAYE Due")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total after PAYE"; Rec."Total after PAYE")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Offset Leave Days"; Rec."Offset Leave Days")
                {
                    ApplicationArea = All;
                }
                field("Amount In Lieu of Notice"; Rec."Amount In Lieu of Notice")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Payable)
            {
                Caption = 'Payable';
                Visible = SeeTerminalDues;
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ApplicationArea = All;
                }
                field("Amount Payable"; Rec."Amount Payable")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

        }
    }

    actions
    {
        area(processing)
        {
            action("Employee Termination Report")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    REPORT.RUN(50280, TRUE, TRUE, Rec);

                end;
            }
            action("Move to Processing")
            {
                ApplicationArea = All;
                Image = MoveUp;
                Visible = SeeSend;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    if Confirm(Text000) then begin
                        Rec."Separation Status" := Rec."Separation Status"::Processing;
                        Rec.Modify(true);
                        Message(Text001);
                        CurrPage.Close();
                    end;

                end;
            }

            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                RunObject = page "Document Attachment Details";
                RunPageLink = "No." = field("Separation No");
            }
            action("Mark As Processed")
            {
                Image = Save;
                Visible = SeeTerminalDues;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    HRManagement.UpdateSeparationInfo(Rec);
                end;
            }
        }
    }

    var
        HRManagement: Codeunit "HR Management";
        SeeTerminalDues: Boolean;
        SeeSend: Boolean;
        Text000: Label 'Are you sure you want to move this request to processing?';
        Text001: Label 'Moved to processing successfully!';

    trigger OnOpenPage()
    begin
        if Rec."Separation Status" = Rec."Separation Status"::New then begin
            SeeTerminalDues := false;
            SeeSend := true;
        end;
        if Rec."Separation Status" = Rec."Separation Status"::Processed then
            CurrPage.Editable(false);
        if Rec."Separation Status" = Rec."Separation Status"::Processing then
            SeeTerminalDues := true;
    end;

}
